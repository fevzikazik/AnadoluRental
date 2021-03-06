﻿using AnadoluRental.CrossCutting.Concretes.Helper;
using AnadoluRental.CrossCutting.Concretes.Logger;
using AnadoluRental.Models.Models;
using AnadoluRentalWeb.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace AnadoluRentalWeb.Controllers
{
    public class KiralikController : Controller
    {
        string Baseurl = "http://localhost:54361/";

        // GET: Kiralik
        public async Task<ActionResult> Index()
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");


            Kullanici gelenK = (Kullanici)Session["kull"];

            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(Baseurl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                    IList<Kiralik> kiralikListesi = null;
                    using (var result = await client.GetAsync("api/Kiralik"))
                    {
                        if (result.IsSuccessStatusCode)
                        {
                            var value = result.Content.ReadAsStringAsync().Result;

                            //kiralikListesi = JsonConvert.DeserializeObject<ResponseContent<Kiralik>>(value).Data.ToList();

                            if (gelenK.kullRolID == 1) // Admin ise..
                            {
                                kiralikListesi = JsonConvert.DeserializeObject<ResponseContent<Kiralik>>(value).Data.ToList();
                            }
                            else if ((gelenK.kullRolID == 2 || gelenK.kullRolID == 3) && gelenK.kullSirketID > 0) // Yönetici veya Çalışan ise..
                            {
                                kiralikListesi = JsonConvert.DeserializeObject<ResponseContent<Kiralik>>(value).Data.Where(kira => (kira.Arac.aitOlduguSirketID == gelenK.kullSirketID)).ToList();
                            }
                            else
                            {
                                kiralikListesi = null;
                            }
                        }
                    }
                    return View(kiralikListesi);
                }
            }
            catch (Exception ex)
            {
                LogHelper.Log(LogTarget.File, ExceptionHelper.ExceptionToString(ex), true);
                throw new Exception("Hata Oluştu" + ex.Message);
            }
        }

        // GET: Kiralik/Goruntule/5
        public ActionResult Goruntule(int id)
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");

            return View(id);
        }

        // GET: Kiralik/YeniOlustur
        public async Task<ActionResult> YeniOlustur(int id)
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");

            using (var client = new HttpClient())
            {
                client.BaseAddress = new Uri(Baseurl);
                client.DefaultRequestHeaders.Accept.Clear();
                client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));

                IList<Arac> aracList = null;
                using (var result = await client.GetAsync("api/Arac"))
                {
                    if (result.IsSuccessStatusCode)
                    {
                        var value = result.Content.ReadAsStringAsync().Result;

                        aracList = JsonConvert.DeserializeObject<ResponseContent<Arac>>(value).Data.ToList();
                    }
                }
                IList<Kullanici> kullList = null;
                using (var result = await client.GetAsync("api/Kullanici"))
                {
                    if (result.IsSuccessStatusCode)
                    {
                        var value = result.Content.ReadAsStringAsync().Result;

                        kullList = JsonConvert.DeserializeObject<ResponseContent<Kullanici>>(value).Data.ToList();
                    }
                }

                ViewBag.aracList = aracList;
                ViewBag.kullList = kullList;
                ViewBag.kiralanacakID = id;


                return View();
            }
        }

        // POST: Kiralik/YeniOlustur
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<ActionResult> YeniOlustur(FormCollection collection)
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");

            if (!ModelState.IsValid)
            {
                return View();
            }
            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(Baseurl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(
                        new MediaTypeWithQualityHeaderValue("application/json"));

                    Kiralik kiralik = new Kiralik();
                    kiralik.kiralananAracID = int.Parse(collection["kiralananAracID"]);
                    kiralik.kiraTarihi = DateTime.Parse(collection["kiraTarihi"]);
                    kiralik.verilisKM = int.Parse(collection["verilisKM"]);
                    kiralik.kiraBitisKM = int.Parse(collection["kiraBitisKM"]);
                    kiralik.kiraAlinanUcret = int.Parse(collection["kiraAlinanUcret"]);
                    kiralik.kiralayanKulID = int.Parse(collection["kiralayanMusteri"]);

                    var serializedProduct = JsonConvert.SerializeObject(kiralik);
                    var content = new StringContent(serializedProduct, Encoding.UTF8, "application/json");
                    var result = await client.PostAsync("api/Kiralik", content);
                    if (result.IsSuccessStatusCode)
                        return RedirectToAction("Index");


                    return RedirectToAction("YeniOlustur");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Log(LogTarget.File, ExceptionHelper.ExceptionToString(ex), true);
                return RedirectToAction("YeniOlustur");
            }
        }

        // GET: Kiralik/Duzenle/41
        public async Task<ActionResult> Duzenle(int id)
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");

            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(Baseurl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(
                        new MediaTypeWithQualityHeaderValue("application/json"));

                    IList<Kullanici> kullList = null;
                    using (var result = await client.GetAsync("api/Kullanici"))
                    {
                        if (result.IsSuccessStatusCode)
                        {
                            var value = result.Content.ReadAsStringAsync().Result;

                            kullList = JsonConvert.DeserializeObject<ResponseContent<Kullanici>>(value).Data.ToList();
                        }
                    }

                    ViewBag.kullList = kullList;

                    Kiralik kiralik = null;

                    using (var result = await client.GetAsync("api/Kiralik/" + id))
                    {
                        if (result.IsSuccessStatusCode)
                        {
                            var value = result.Content.ReadAsStringAsync().Result;

                            kiralik = JsonConvert.DeserializeObject<ResponseContent<Kiralik>>(value).Data.ToList().First();

                            return View(kiralik);
                        }
                    }
                }
                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                LogHelper.Log(LogTarget.File, ExceptionHelper.ExceptionToString(ex), true);
                throw new Exception("Hata Oluştu", ex);
            }
        }

        // POST: Kiralik/Duzenle/41
        [HttpPost]
        public async Task<ActionResult> Duzenle(int id, FormCollection collection)
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");

            if (!ModelState.IsValid)
            {
                return RedirectToAction("Index");
            }
            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(Baseurl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(
                        new MediaTypeWithQualityHeaderValue("application/json"));

                    Kiralik kiralik = new Kiralik();
                    kiralik.kiraID = id;
                    kiralik.kiralananAracID = int.Parse(collection["kiralananAracID"]);
                    kiralik.kiraTarihi = DateTime.Parse(collection["kiraTarihi"]);
                    kiralik.verilisKM = int.Parse(collection["verilisKM"]);
                    kiralik.kiraBitisKM = int.Parse(collection["kiraBitisKM"]);
                    kiralik.kiraAlinanUcret = int.Parse(collection["kiraAlinanUcret"]);
                    kiralik.kiralayanKulID = int.Parse(collection["kiralayanMusteri"]);

                    var serializedProduct = JsonConvert.SerializeObject(kiralik);
                    var content = new StringContent(serializedProduct, Encoding.UTF8, "application/json");
                    var result = await client.PutAsync("api/Kiralik/" + id, content);
                    if (result.IsSuccessStatusCode)
                        return RedirectToAction("Index");

                    return RedirectToAction("Duzenle", id);
                }
            }
            catch(Exception ex)
            {
                return RedirectToAction("Duzenle", id);
            }
        }

        // GET: Kiralik/Sil/41
        public async Task<ActionResult> Sil(int id)
        {
            if (Session["kull"] == null)
                return RedirectToAction("Index", "Home");

            try
            {
                using (var client = new HttpClient())
                {
                    client.BaseAddress = new Uri(Baseurl);
                    client.DefaultRequestHeaders.Accept.Clear();
                    client.DefaultRequestHeaders.Accept.Add(
                        new MediaTypeWithQualityHeaderValue("application/json"));

                    var result = await client.DeleteAsync("api/Kiralik/" + id);
                    if (result.IsSuccessStatusCode)
                        return RedirectToAction("Index");
                    return RedirectToAction("Index");
                }
            }
            catch (Exception ex)
            {
                LogHelper.Log(LogTarget.File, ExceptionHelper.ExceptionToString(ex), true);
                throw new Exception("Hata Oluştu", ex);
            }
        }
    }
}
﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AnadoluRental.Models.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class dbAnadoluRentalEntities : DbContext
    {
        public dbAnadoluRentalEntities()
            : base("name=dbAnadoluRentalEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Arac> Arac { get; set; }
        public virtual DbSet<Kiralik> Kiralik { get; set; }
        public virtual DbSet<Kullanici> Kullanici { get; set; }
        public virtual DbSet<Rol> Rol { get; set; }
        public virtual DbSet<Sirket> Sirket { get; set; }
    }
}

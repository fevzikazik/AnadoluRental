//------------------------------------------------------------------------------
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
    using System.Collections.Generic;
    
    public partial class Sirket
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Sirket()
        {
            this.Arac = new HashSet<Arac>();
        }
    
        public int sirketID { get; set; }
        public string sirketAdi { get; set; }
        public string sirketSehir { get; set; }
        public string sirketAdres { get; set; }
        public Nullable<int> sirketAracSayisi { get; set; }
        public Nullable<int> sirketPuani { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Arac> Arac { get; set; }
    }
}

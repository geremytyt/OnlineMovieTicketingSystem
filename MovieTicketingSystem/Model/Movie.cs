//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace MovieTicketingSystem.Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Movie
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Movie()
        {
            this.Schedules = new HashSet<Schedule>();
        }
    
        public string movieId { get; set; }
        public string movieName { get; set; }
        public System.DateTime releaseDate { get; set; }
        public Nullable<short> movieDuration { get; set; }
        public string genre { get; set; }
        public string language { get; set; }
        public string synopsis { get; set; }
        public string actor { get; set; }
        public string director { get; set; }
        public string ageRating { get; set; }
        public string posterURL { get; set; }
        public string trailerURL { get; set; }
        public short id { get; set; }
        public Nullable<System.DateTime> endDate { get; set; }
        public string slideURL { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Schedule> Schedules { get; set; }
    }
}

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
    
    public partial class Card
    {
        public string cardNo { get; set; }
        public string custId { get; set; }
        public string cvv { get; set; }
        public string cardHolderName { get; set; }
        public System.DateTime expiryDate { get; set; }
    
        public virtual Customer Customer { get; set; }
    }
}

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
    
    public partial class Payment
    {
        public string paymentNo { get; set; }
        public string purchaseNo { get; set; }
        public string paymentType { get; set; }
        public System.DateTime paymentDateTime { get; set; }
        public decimal paymentAmount { get; set; }
        public string accEmail { get; set; }
        public string cardNo { get; set; }
        public string transactionNo { get; set; }
        public string status { get; set; }
    
        public virtual Purchase Purchase { get; set; }
    }
}

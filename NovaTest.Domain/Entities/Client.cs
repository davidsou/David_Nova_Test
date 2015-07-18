using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace NovaTest.Domain.Entities
{
    public class Client
    {

        [Key]
        [HiddenInput(DisplayValue = false)]
        public Int32 idClient { get; set; }
        [Required(ErrorMessage = "Name must be filled", AllowEmptyStrings = false)]
        public String Name { get; set; }
        [Required(ErrorMessage = "Gender must be filled", AllowEmptyStrings = false)]
        public String Gender { get; set; }
        [Required(ErrorMessage = "Birthday must be filled", AllowEmptyStrings = false)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime Birthday { get; set; }
        [Required(ErrorMessage = "Category must be filled", AllowEmptyStrings = false)]
        public String Category { get; set; }

        [Required(ErrorMessage = "Number must be filled", AllowEmptyStrings = false)]
        public Int32 Number { get; set; }

        [Required(ErrorMessage = "Street must be filled", AllowEmptyStrings = false)]
        public String Address { get; set; }

        [Required(ErrorMessage = "State must be filled", AllowEmptyStrings = false)]
        public String State { get; set; }

        [Required(ErrorMessage = "Country must be filled", AllowEmptyStrings = false)]
        public String Country { get; set; }

        [HiddenInput(DisplayValue = false)]
        public Char TypeOperation { get; set; }

        [HiddenInput(DisplayValue = false)]
        public String UserOperation { get; set; }

        [HiddenInput(DisplayValue = false)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy}", ApplyFormatInEditMode = true)]
        public DateTime DataOperation { get; set; }

        [HiddenInput(DisplayValue = false)]
        public Boolean IsActive { get; set; }



    }
}


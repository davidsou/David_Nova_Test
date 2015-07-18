using NovaTest.Domain.Entities;
using NovaTest.Domain.Repository;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NovaTest.Web.Controllers
{
    public class QueryController : Controller
    {
        private ClientRepository _repository;

        public ActionResult ByName()
        {
            return View();
        }

        [HttpPost]
        public ActionResult ByName(string searchname)
        {

            _repository = new ClientRepository();
            var r = _repository.QueryByName(searchname);
            return PartialView("_ByName", r);
        }



        public ActionResult Count(String name)
        {
            _repository = new ClientRepository();
            List<CountClients> r = _repository.QueryCount ();
            return View(r);
        }


    }
}
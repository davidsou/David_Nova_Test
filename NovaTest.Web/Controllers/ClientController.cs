using NovaTest.Domain.Repository;
using NovaTest.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace NovaTest.Web.Controllers
{
    public class ClientController : Controller
    {
        private ClientRepository _repository;
        // GET: Client
        public ActionResult Index()
        {
            _repository = new ClientRepository();
            var clients = _repository.Clients;

            return View(clients);
        }

        public ActionResult Create()
        {
            return View();
        }


        public ViewResult Edit(int idClient)
        {
            _repository = new ClientRepository();
            Client client = _repository.Clients.FirstOrDefault(p => p.idClient == idClient);

            return View(client);
        }

        [HttpPost]
        public ActionResult Edit(Client client)
        {
            if (ModelState.IsValid)
            {
                String msg = client.idClient == 0 ? "created" : "updated";
                _repository = new ClientRepository();
                _repository.Save(client);


                TempData["mensagem"] = string.Format("{0} was {1}", client.Name, msg);

                return RedirectToAction("Index");
            }

            return View(client);
        }

        public ViewResult NewClient()
        {
            return View("Edit", new Client());
        }


        [HttpPost]
        public ActionResult Delete(int idClient)
        {
            _repository = new ClientRepository();

            Client cli = _repository.Delete(idClient);

            if (cli != null)
            {
                TempData["mensagem"] = string.Format("{0} was deleted", cli.Name);
            }

            return RedirectToAction("Index");
        }


        //[HttpPost]
        //public JsonResult Delete(int idClient)
        //{
        //    String message = String.Empty;
        //    _repository = new ClientRepository();

        //    Client cli = _repository.Delete(idClient);

        //    if (cli != null)
        //    {
        //        message = string.Format("{0} was deleted", cli.Name);
        //    }

        //    return Json(message, JsonRequestBehavior.AllowGet); ;
        //}
    }
}
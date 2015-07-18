using NovaTest.Domain.Entities;
using System;
using System.Collections.Generic;
using System.Data.Entity.SqlServer;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NovaTest.Domain.Repository
{
    public class ClientRepository
    {
        private readonly EfDbContext _context = new EfDbContext();
        public IEnumerable<Client> Clients
        {
            get { return _context.Clients; }
        }

        public void Save(Client client)
        {
            if (client.idClient == 0)
            {
                client.TypeOperation = 'I';
                client.UserOperation = "TESTES";
                client.DataOperation = DateTime.Now;

                _context.Clients.Add(client);
            }
            else
            {
                Client cli = _context.Clients.Find(client.idClient);
                if (cli != null)
                {
                    cli.Name = client.Name;
                    cli.Birthday = client.Birthday;
                    cli.Category = client.Category;
                    cli.Gender = client.Gender;
                    cli.TypeOperation = 'U';
                    cli.UserOperation = "SYSTEM";
                    cli.DataOperation = DateTime.Now;
                }
            }
            _context.SaveChanges();
        }

        public Client Delete(int idClient)
        {

            Client prod = _context.Clients.Find(idClient);

            if (prod != null)
            {
                _context.Clients.Remove(prod);
                _context.SaveChanges();
            }

            return prod;
        }

        public IEnumerable<Client> QueryByName(String name)
        {

            var test = from p in _context.Clients
                       where SqlFunctions.SoundCode(p.Name) == SqlFunctions.SoundCode(name)
                       select p;

            return test.ToList<Client>();
        }

        public Client QueryCode(int id)
        {

            Client a = _context.Clients.Find(id);

            return a;
        }

        public List<CountClients> QueryCount()
        {
            List<CountClients> l = new List<CountClients>();

            //var qty = _context.Clients.GroupBy(x => x.Gender  ).Select(group => new
            //{
            //    categoria = group.Key,
            //    count = group.Count()
            //}).OrderBy(x => x.categoria);

            //int total = qty.Sum(y => y.count);

            //foreach (var t in qty)
            //{
            //    CountClients qtd = new CountClients { Category = t.categoria, Quantity = t.count, Percentual = (t.count * 100) / total };
            //    l.Add(qtd);
            //}


            var clients = from xpto in _context.Clients
                    orderby xpto.Category 
                    group xpto by new
                    {
                        xpto.Category,
                        xpto.State,
                        
                    } into xcs
                    select new CountClients()
                    {
                        Category = xcs.Key.Category,
                        State = xcs.Key.State,
                        Quantity = xcs.Count()
                    };
            int total = clients.Sum(y=> y.Quantity );
            foreach (var t in clients)
            {
                CountClients qtd = new CountClients {State=t.State,  Category = t.Category, Quantity = t.Quantity, Percentual = Math.Round((double) (t.Quantity * 100) / total,3) };
                l.Add(qtd);
            }
            return l;


        }
    }


}

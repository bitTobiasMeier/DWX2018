using System.Collections.Generic;
using System.Threading.Tasks;
using MenuCardService.Interfaces;
using MenuCardService.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace MenuCardService.Controllers
{
    [Route("api/[controller]")]
    public class MenuCardController : Controller
    {
        private readonly IMenuCardRepository _menuCardRepository;


        public MenuCardController(IMenuCardRepository menuCardRepository)
        {
            _menuCardRepository = menuCardRepository;
        }

        [HttpGet("{id}")]
        public async Task<MenuData> GetAsync(int id)
        {
            return await this._menuCardRepository.GetMenuAsync(id);
        }

        [HttpGet()]
        public async Task<List<MenuData>> GetAllAsync()
        {
            return await this._menuCardRepository.GetAllAsync();
        }

        [HttpPost]
        public async Task<MenuData> PostAsync([FromBody] MenuData value)
        {
            return await _menuCardRepository.AddMenuAsync(value);
        }
    }
}
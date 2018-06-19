using System.Threading.Tasks;
using MenuCardService.Interfaces;

namespace MenuCardService.Repositories
{
    public interface IMenuCardRepository
    {
        Task<MenuData> AddMenuAsync(MenuData menuData);
        Task<MenuData> GetMenuAsync(int id);
    }
}
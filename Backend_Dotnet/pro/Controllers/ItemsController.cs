using Microsoft.AspNetCore.Mvc;
using MongoDB.Bson;
using pro.models;
using pro.services;
using RestClient;
using System.Text.Json;
using Newtonsoft.Json.Linq;


namespace pro.Controller;

[Route("api/[controller]")]
[ApiController]
public class ItemsController : ControllerBase
{
    private readonly ItemService _itemService;

    public ItemsController(ItemService itemService)
    {
        _itemService = itemService;
    }


    [HttpGet]
    public async Task<IActionResult> Get()
    {
        var allItems = await _itemService.GetItemsAsync();
        if (allItems == null)
        {
            return NotFound("sorry");
        }
        return Ok(allItems);
    }


    [HttpGet("id")]
    public async Task<IActionResult> Get(string id)
    {
        var item = await _itemService.GetItem(id);
        if (item == null)
        {
            return NotFound("sorry");
        }
        return Ok(item);
    }


    [HttpPost]
    public async Task<IActionResult> Post(Items item)
    {
        item.id = ObjectId.GenerateNewId();
        await _itemService.CreateItemAsync(item);
        return CreatedAtAction(nameof(Get), routeValues: new { title = item.title }, value: item);

    }


    [HttpPatch("id")]
    public async Task<IActionResult> UpdateEntity([FromBody] PatchReq req)
    {

        var found = await _itemService.GetItem(req.id);
        if (found != null)
        {

            await _itemService.Patch(req);
            return Ok("It has been edited");

        }
        else
        {
            return NotFound();
        }

    }


    [HttpDelete("id")]
    public async Task<IActionResult> Delete(string sellerId, string id)
    {

        var found = await _itemService.GetItem(id);
        if (found != null)
        {
            if (sellerId == found.sellerId)
            {
                await _itemService.DeleteItem(id);
                return Ok("Deleted Successfully");
            }
            else
            {
                return StatusCode(403);
            }

        }
        else
        {
            return NotFound();
        }
    }
    [HttpGet("rates")]

    public async Task<IActionResult> GetRates()
    {
        string uri = "https://v6.exchangerate-api.com/v6/7a25fe8b3adafdd708c9493e/latest/USD";
        var client = new HttpClient();

        HttpResponseMessage res = await client.GetAsync(uri);
        HttpContent cont = res.Content;
        var data = await cont.ReadAsStringAsync();
        // JObject json = JObject.Parse();


        return Ok(data);

    }

    [HttpPut("id")]

    public async Task<IActionResult> UpdateItem(string sellerId, string id, Items item)
    {

        var existingItem = await _itemService.GetItem(id);

        if (existingItem != null)
        {
            if (sellerId == item.sellerId)
            {
                item.id = existingItem.id;

                await _itemService.UpdateItemAsync(item);
                return Ok("Entity Updated");
            }
            else
            {
                return StatusCode(403);
            }
        }
        else
        {
            return NotFound();
        }
    }



}






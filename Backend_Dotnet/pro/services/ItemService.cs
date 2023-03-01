
using MongoDB.Driver;
using pro.models;
using RestClient;

using Microsoft.Extensions.Options;
using MongoDB.Bson;
using RestSharp;

namespace pro.services;

public class ItemService
{
    private readonly IMongoCollection<Items> _itemCollection;

    public ItemService(IOptions<MongoDBSettings> mongosettings)
    {

        var client = new MongoClient(mongosettings.Value.ConnectionUri);
        var mongo = client.GetDatabase(mongosettings.Value.DatabaseName);
        _itemCollection = mongo.GetCollection<Items>("items");
    }


    public async Task<List<Items>> GetItemsAsync() => await _itemCollection.Find(filter: _ => true).ToListAsync();
    public async Task CreateItemAsync(Items item) => await _itemCollection.InsertOneAsync(item);
    public async Task UpdateItemAsync(Items item) => await _itemCollection.ReplaceOneAsync(filter: x => x.id == item.id, item);
    public async Task DeleteItem(string id) => await _itemCollection.DeleteOneAsync(filter: x => x.id.ToString().Equals(id));
    public async Task<Items> GetItem(string id) => await _itemCollection.Find(filter: x => x.id.ToString() == id).FirstOrDefaultAsync();
    public async Task Patch(PatchReq req)
    {

        // Console.WriteLine(req.ToJson());
        var Filter = new BsonDocument().Add(name: "amount", req.amount);
        var up = new BsonDocument(name: "$set", Filter);

        var res = await _itemCollection.UpdateOneAsync(filter: x => x.id.ToString() == req.id, up);
        if (res != null)
        {
            Console.WriteLine("that worked");
            Console.WriteLine(res.ToString());

        }
        else
        {
            Console.WriteLine("no it didn't");
        }
    }






}

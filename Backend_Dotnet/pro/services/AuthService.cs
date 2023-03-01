using Microsoft.Extensions.Options;
using MongoDB.Driver;
using pro.models;
namespace pro.services;

public class AuthService
{
    private readonly IMongoCollection<User> _userCollection;

    public AuthService(IOptions<MongoDBSettings> mongosettings)
    {

        var client = new MongoClient(mongosettings.Value.ConnectionUri);
        var mongo = client.GetDatabase(mongosettings.Value.DatabaseName);

        _userCollection = mongo.GetCollection<User>("user");

    }

    public async Task<List<User>> GetUsers() => await _userCollection.Find(filter_ => true).ToListAsync();
    public async Task CreateUser(User user) => await _userCollection.InsertOneAsync(user);
    public async Task<User> GetUser(string id) => await _userCollection.Find(filter: x => x.id.ToString() == id).FirstOrDefaultAsync();
    public async Task<User> CheckUser(string email) => await _userCollection.Find(filter: x => x.email == email).FirstOrDefaultAsync();
}

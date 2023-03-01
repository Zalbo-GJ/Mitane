using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

namespace pro.models;

public class User
{

    [BsonId]
    [BsonRepresentation(MongoDB.Bson.BsonType.ObjectId)]
    public ObjectId? id { get; set; } = null!;
    [BsonElement("name")]
    public string name { get; set; } = null!;
    [BsonElement("email")]
    public string email { get; set; } = null!;
    [BsonElement("password")]
    public string password { get; set; } = null!;


}
public class SignIn
{

    [BsonElement("email")]
    public string email { get; set; } = null!;
    [BsonElement("password")]
    public string password { get; set; } = null!;


}



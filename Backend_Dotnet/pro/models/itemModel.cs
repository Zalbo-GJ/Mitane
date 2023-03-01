using System.ComponentModel.DataAnnotations;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace pro.models;

public class Items
{
    [BsonId]
    [BsonRepresentation(MongoDB.Bson.BsonType.ObjectId)]
    public ObjectId? id { get; set; } = null!;

    [BsonElement("title")]
    public string title { get; set; } = null!;
    [BsonElement("img")]

    public string img { get; set; } = null!;
    [BsonElement("amount")]
    public int amount { get; set; }
    [BsonElement("price")]
    public int price { get; set; }
    [BsonElement("sellerId")]
    public String? sellerId { get; set; } = null!;



}
public class PatchReq
{

    public String id { get; set; }

    public int amount { get; set; }

    public String? sellerId { get; set; }

}

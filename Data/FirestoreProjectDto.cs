using Google.Cloud.Firestore;

namespace Firebase.Realtime.BlazorServer.Example.Data;

[FirestoreData]
public class FirestoreProjectDto
{
    [FirestoreProperty("name")]
    public string Name { get; set; } = "";
    
    [FirestoreProperty("description")]
    public string Description { get; set; } = "";
    
    [FirestoreProperty("image_url")]
    public string ImageUrl { get; set; } = "";
    
    [FirestoreProperty("url")]
    public string Url { get; set; } = "";
    
    public DateTime Creation { get; set; }
}
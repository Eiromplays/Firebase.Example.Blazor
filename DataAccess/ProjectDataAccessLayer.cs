using Firebase.Realtime.BlazorServer.Example.Data;
using Google.Cloud.Firestore;

namespace Firebase.Realtime.BlazorServer.Example.DataAccess;

public class ProjectDataAccessLayer
{
    private readonly FirestoreDb _db;

    public ProjectDataAccessLayer(IConfiguration configuration)
    {
        Environment.SetEnvironmentVariable("GOOGLE_APPLICATION_CREDENTIALS",
            configuration.GetValue<string>("Firestore:GOOGLE_APPLICATION_CREDENTIALS"));
        _db = FirestoreDb.Create(configuration["Firestore:ProjectId"]);
    }

    public async Task<List<FirestoreProjectDto>> GetAllAsync(CancellationToken cancellationToken = default)
    {
        var projectsQuery = _db.Collection("projects");
        var projectsQuerySnapshot = await projectsQuery.GetSnapshotAsync(cancellationToken);

        var projects = projectsQuerySnapshot.Documents.Select(x =>
        {
            var project = x.ConvertTo<FirestoreProjectDto>();
            project.Creation = x.CreateTime!.Value.ToDateTime();
            return project;
        }).ToList();

        return projects;
    }
}
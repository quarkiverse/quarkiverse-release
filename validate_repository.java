import java.io.FileInputStream;
import java.util.Properties;

public class validate_repository {

    public static void main(String[] args) throws Exception {
//        Path artifactDir = Path.of(System.getenv("ARTIFACT_DIR"));
        String repository = System.getenv("REPOSITORY");
        String name = System.getenv("NAME");
//        String version = System.getenv("VERSION");
        // Verify if the repository pattern is valid
        Properties prop = groupIdMapping();
        // Check if the artifacts are from the authorized group Id
        if (!prop.containsKey(repository)) {
            throw new Exception("Group Id not found in the mapping files for the repository: " + repository);
        }
        //TODO: Perform other checks here
    }

    private static Properties groupIdMapping() throws Exception {
        Properties prop = new Properties();
        try (FileInputStream fis = new FileInputStream("mapping.properties")) {
            prop.load(fis);
        }
        try (FileInputStream fis = new FileInputStream("quarkiverse-mapping.properties")) {
            prop.load(fis);
        }
        return prop;
    }
}

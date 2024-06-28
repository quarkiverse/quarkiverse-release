import java.io.File;

public class validate_repository {

    public static void main(String[] args) {
        System.out.println(new File(System.getenv("ARTIFACT_DIR")).exists());
        System.out.println("Hello, World");
    }
}

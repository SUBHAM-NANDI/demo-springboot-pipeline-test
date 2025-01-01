# demo-springboot-pipeline-test
![WhatsApp Image 2024-12-20 at 16 30 59](https://github.com/user-attachments/assets/24538f05-5616-474b-a0f0-e859b68c1e36)

Summary of the steps in your Jenkins pipeline:

1.⁠ ⁠*Git Checkout*: Clones the ⁠ main ⁠ branch of the GitHub repository to retrieve the source code for the pipeline.

2.⁠ ⁠*Code Compile*: Compiles the Java code using Maven to ensure there are no syntax or dependency errors.

3.⁠ ⁠*Unit Test*: Runs unit tests using Maven to validate the functionality of individual components.

4.⁠ ⁠*SonarQube Analysis*: Performs static code analysis with SonarQube to identify code quality issues and technical debt.

5.⁠ ⁠*OWASP Dependency Check*: Scans for known security vulnerabilities in the project dependencies using the OWASP Dependency-Check tool.

6.⁠ ⁠*Build Artifact*: Packages the application into a JAR file using Maven, preparing it for deployment.

7.⁠ ⁠*Docker Build & Push*:
   - Builds a Docker image with the packaged application.
   - Tags the image with the local Docker registry address (⁠ localhost:5000 ⁠).
   - Pushes the tagged image to the local Docker registry for further use in deployment.

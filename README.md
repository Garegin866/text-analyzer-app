## Text Analyzer

This is a simple Qt application that analyzes a text file and displays the most frequently used words.

*Features:*

- Reads a text file.
- Counts word occurrences.
- Displays the top 15 most frequent words.

*Requirements:*

- Qt framework

*How to Use:*

- Clone this repository or download the source files.
- Open CMakeLists.txt in your Qt IDE (e.g., Qt Creator).
- Configure and build the project.
- Run the executable.
- Select a text file to analyze.

*Project Structure:*

The application follows a Model-View-Controller (MVC) architecture for separation of concerns:

*Model - WordCountModel:*

This class is responsible for storing and managing word counts. It uses a QHash<QString, int> internally to map words (keys) to their corresponding counts (values). It provides methods to:
- Add words (addWord) and update their counts.
- Reset the data (reset).
- Retrieve the top n words as a JSON object (getTopWords). This allows the view to efficiently access the most frequent words for display.

*View - QML User Interface:* 

- Data visualization components (histogram or table) to represent the top words and their counts. These components receive data from the model as a JSON object.
- A progress bar to indicate file processing progress.

*Controller - FileProcessorController:*

This class acts as the intermediary between the user interface (view) and the model. It handles user interaction and file processing logic:
- Exposes properties like the filename (filename) and processing state (isProcessing).
- Starts and stops the file processing in a separate thread (startProcessing, stopProcessing). This thread reads the file content, processes each word, and updates the WordCountModel on the main thread using signals and slots.

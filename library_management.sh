#!bin/bash

# Prompt user for input
echo "Simple Library Manager"
echo "Please enter the name of the library: "
read libraryName

# Create the library
mkdir $libraryName

# Create the subdirectories
mkdir $libraryName/books $libraryName/students

# Create the necessary files
touch $libraryName/books/bookList.txt
touch $libraryName/students/studentList.txt

echo "Your library $libraryName has been created!"

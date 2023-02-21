This book contains Python code to create versions of each of the figures presented in [*Statistical Thinking: Analyzing Data in an Uncertain World*](https://press.princeton.edu/books/hardcover/9780691250939/statistical-thinking), by Russell Poldrack, published by Princeton University Press.


Copyright 2023 Russell Poldrack

The materials in this set of notebooks are released under a [Creative Commons Attribution-NonCommercial 4.0 International (CC BY-NC 4.0) license](https://creativecommons.org/licenses/by-nc/4.0/).



Note: Some of the results differ between these examples and the book, due to differences in random sampling and filtering of the data in some cases.

The notebooks are organized by chapter, and are named according to the figure number in the book.

The raw notebooks are available in the `src` directory.

## Docker setup

A [Dockerfile](Dockerfile) is provided to build a container with all the necessary dependencies.  The commands to build the container can be found in the [Makefile](Makefile).  Note that it will require some modifications to the Dockerfile if you wish to mount local volumes, as the UID for the docker user should match your local user.


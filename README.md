# Python Primer Course
* This project assumes you have Python and a bash terminal installed

### When to use Python
* Are you scripting?
    * Python is a highly optimized scripting language
* Are you in need of very precise mathematical calculations?
    * Python has an extensive collection of math libraries
    * It is rapidly replacing the R language
    * It is great for Data Analytics, Machine Learning, and AI
* Are you rapidly prototyping?
    * Flask allows for quick scaffolding of APIs
    * Easy json serialization/deserialization makes ETL processes simple

### Getting Started
1. Configure Proxy
    * replace the username and password placeholder with your user and pass the `enableEnv.sh`
    * if you have any special characters in your password replace with [url encoded characters](https://www.w3schools.com/tags/ref_urlencode.asp)
2. Install `virtualenv`
    * navigate to the directory for the project using `cd`
    * execute `source ./enableEnv.sh` to configure proxy and install virtualenv
    * these commands can be aliased in your `.bashrc` file or typed out manually for future needs 
3. Create a virtual environment (venv)
    * execute `virtualenv venv` 
        * this will install the interpreter, pip, and scripts into the newly created `venv` folder
    * all dependencies are now install into this directory and have global isolation
4. Activate Virtual Environment to install Dependencies
    * execute `source ./venv/Scripts/activate`
        * this will only enable the virtual environment for this terminal window
    * to deactivate the virtual environment execute `deactivate`
5. Add Dev and Prod Requirements files
    * create file at root called `requirements.txt` and add any libraries you need for prod
    * create file at root called `test_requirements.txt` and add any test libraries
6. Install dependencies
    * execute `pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -Ur  requirements.txt`
    * execute `pip install --trusted-host pypi.org --trusted-host files.pythonhosted.org -Ur  test_requirements.txt`
7. Point editor to venv JetBrains Interpreter
    * IntelliJ
        * click `File` -> `Project Structure`
        * under `Project SDK` click the `new` button and select `Python SDK`
        * select `Existing Environment` then use the `...` to navigate to `/venv/Scripts/python.exe`
    * Pycharm
        * click `File` -> `Settings`
        * in search type "Interp" and select the `Python Interpretor`
        * use the `...` to navigate to `/venv/Scripts/python.exe`

### Executing our code

### Best Practices
* [Zen of Python](https://scm.principal.com/projects/USISDOJO/repos/dojo-engineering/browse/engineering-culture/python-zen.md)
# Web Terminal
CoffeScript web terminal


## Usage

    $ coffee shell

Then open your web browser and go to:

    http://localhost:3000
    
If using on a network for multiple network access, make sure to edit line #15 on index.ejs to:

    var socket = io.connect('http://server_ip_address');
    

# Credits
Michael Pivonka Aka [TehCodedNinja](https://github.com/tehcodedninja) for base of code.
Jakub Jankiewicz Aka [jcubic](https://github.com/jcubic) for [jQuery Terminal](http://terminal.jcubic.pl/)
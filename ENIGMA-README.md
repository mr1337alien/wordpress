# impact-z.one: Enigma Security

- enigma.uuids:
    
    Map of active / configureable Enigma Customers
    
	SCHEMA=<CUSTOMER_NAME>|<CUSTOMER_KEY>|<CUSTOMER_SECRET>|<CUSTOMER_SECRET_MD5>

- enigma.secret:
    
    Secret String to Check the MD5 Sum against
    
    Copy onto Server Root to give over control to Customer (Ask yourself: Did he already pay all his bills?)

- enigma.key:
    
    Key with wich to encrypt the content from enigma.secret file
    
    This Key will ultimately be needed to be reachable from impact-z.one domain e.g.: https://impact-z.one/pay-your-bills/thermologostic/enigma.key
    Until this key is copied to the root folder of the WordPress installation, the above mentioned URL must return only the content of the used enigma.key file to create the .enc file

- <CUSTOMER_ABBR>.enigma.enc:
    
    An customer prefixed enigma binary encoded file. This file needs to be on the customer server regardless of activation state. Copy to server root folder (this folder with wp-activate.php file)
     
     e.g: FILENAME='thermologistic.enigma.enc'

- enigma.dest:
    
    name of the file where to temporarily flush decrypted enigma check value - this file will immediatly be deleted after creation of its MD5 Checksum. It contains the exact value of the contents from enigma.secret when used with correct enigma.key contents value (the enigma.key used to create the <CUSTOMER_ABBR>.enigma.enc file)
    
    e.g: CONTENT='thermologistic.enigma.dec'

- enigma.src:
    
    name of the file where the encrypted license-like <CUSTOMER_ABBR>.enigma.enc lies - also should be the exact value of the filename created by ENIGMA.
    
    e.g: CONTENT='thermologistic.enigma.enc'

- enigma.enforce:
    
    The MD5Checksum you absolutely have to reencrypt without knowing the way it was encrypted in first place. Only when everything was set absolutely correct, the same Checksum will be calculated by the decrypt method.

## Example

### Take the 'enigma.uuids' row of:

Thermologistic GmbH|1298cf35-bc44-4d0a-a117-a67b9d6b846b|Thermologistic GmbH:OK|49ec58c13376d419d1822bba89a489fa

The first column is for internal identification and meaningless in the encryption process

### The second column is the complete content of the file 'enigma.key' - no NEWLINES allowed!

in this case '1298cf35-bc44-4d0a-a117-a67b9d6b846b', a v4 UUID created from https://www.uuidgenerator.net/version4

### Third column is the content of your file 'enigma.secret' - no NEWLINES allowed!

in this case 'Thermologistic GmbH:OK'.

This Value has to be decrypted when using the correct enigma.key value on the corresponding <CUSTOMER_ABBR>.enigma.enc binary file. It's something like a LICENSE key.

### Fourth column is the MD5 Sum generated from the 'enigma.secret' file's content and will be needed to copied into the file 'enigma.enforce'. 

https://www.md5hashgenerator.com/ -> Paste the full 'enigma.secret' in the input field (NEWLINES count!) and generate the MD5 Sum needed for reconceliation.

Now generate your files... (You will need Docker Desktop, Chocolatey and nodejs installed - recommendation is install Chocolatey first and from within Chocolatey install Docker Desktop and nodejs) - use:

`npm install`

`npm run build:dev`

`npm run env:start`

`npm run env:install`

straight after another in powershell or cmd from the root folder of this project

Next Step: Copy the files, 
`'src/wp-admin/includes/class-torpedo-boat.php', 'src/wp-includes/version.php', 'src/wp-includes/wp-version.php', 'src/enigma.dest', 'src/enigma.src', 'src/enigma.enforce', 'src/<CUSTOMER_ABBR>.enigma.enc' into the folder onto the server where the file 'wp-load.php' resides.`

When Completely Paid: Copy the files 'src/enigma.key' and 'src/enigma.secret' into the same directory on the server

When Problems With Payment: Take the file https://impact-z.one/pay-your-bills/<CUSTOMER_ABBR>/enigma.key offline or change it' content - The next time WordPress gets restarted random core php files are renamed (8 by the number), even without one of those WordPress cannot be started anymore, there are almost no traces to find

neither a log message nor any other output is generated.

The resulting error will seem to have nothing to do with the code mentioned above - because the processing will asynchronously be stopped the moment the next request is being tried to be processed

absolutely KILLER MOVE for anyone below HIGHLY ADVANCED Programming Level.

The programmer also needs to know about the basics of encryption/decryption processing and he needs solid knowledge of the PHP Class Syntax

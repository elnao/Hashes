# Bitfit-Create-Hashes.ps1
# https://github.com/elnao/Forensics
# Copy this file to the root of your forensic tools directory.  Run after you have assembled all of your forensic tools. 
#  All files will be hashed and the results copied to a file named VERSION-yyyyMMddThhmmssZ.txt

.\bitfit.exe .\ > VERSION-$(((get-date).ToUniversalTime()).ToString("yyyyMMddThhmmssZ")).txt
pause

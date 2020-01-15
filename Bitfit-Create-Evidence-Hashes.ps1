# Bitfit-Create-Evidence-Hashes.ps1
# https://github.com/elnao/Forensics
# Copy this file and bitfit.exe to the root of your evidence directory.  Run after you have colleccted all of you evidence.  
#  All files will be hashed and the results copied to a file named VERSION-Evidence-yyyyMMddThhmmssZ.txt

.\bitfit.exe .\ > VERSION-Evidence-$(((get-date).ToUniversalTime()).ToString("yyyyMMddThhmmssZ")).txt
pause
Ru

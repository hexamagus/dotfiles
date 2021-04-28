#!/usr/bin/env bash

sshfs \
	octal@maven.whatbox.ca:/home/octal/files/music/redbetter_again ~/mnt/redbetter_transcodes \
	-o ServerAliveInterval=15 \
        -o ServerAliveCountMax=20 \
        -o reconnect \
#        -o defer_permissions \
        -o negative_vncache \
        -o volname=vendorname \
        -o IdentitiesOnly=yes \
#        -o IdentityFile=/Users/username/.ssh/keyname \
#        -o PreferredAuthentications=publickey \
        -o Ciphers=chacha20-poly1305@openssh.com \
        -o auto_cache \
	-o cache_timeout=300 \
        -o cache=yes


sshfs \
	octal@maven.whatbox.ca:/home/octal/files/music/ ~/mnt/music_kepler \
	-o ServerAliveInterval=15 \
        -o ServerAliveCountMax=20 \
        -o reconnect \
#        -o defer_permissions \
        -o negative_vncache \
        -o volname=vendorname \
        -o IdentitiesOnly=yes \
#        -o IdentityFile=/Users/username/.ssh/keyname \
#        -o PreferredAuthentications=publickey \
        -o Ciphers=chacha20-poly1305@openssh.com \
        -o auto_cache \
	-o cache_timeout=300 \
        -o cache=yes

# Increase speed with weaker (but still good enough) encrypted Ciphers:
# aes128-ctr, aes192-ctr, aes256-ctr
# The fastest being arcfour256 followed by chacha20-poly1305@openssh.com which both are incredibly secure
# @link https://wiki.mozilla.org/Security/Guidelines/OpenSSH#Configuration
# Performance Benchmarks
# @link http://wiki.csnu.org/index.php/SSH_ciphers_speed_comparison
# @link https://blog.famzah.net/2010/06/11/openssh-ciphers-performance-benchmark/

# Large files should be compressed:
# -o Compression=yes \
# -o CompressionLevel=9 \ # Range: 1-9

# cache_timeout and ServerAliveInterval are set in seconds
# For the cache timeout you might want to set the time, the remote server needs
# to update its files, plus 1/6 to make sure you only get fresh files.

# @TODO Make sure this file is called when the server starts or reboots

# As an alternative, you can use CurlFtpFS, props @screamingdev Mike Pretzlaw
# @link http://curlftpfs.sourceforge.net/

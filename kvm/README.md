QEMU/KVM script examples

## Scripts

- QEMU
	- `vm-start`
		- Reference to build a new script

		*or*

		- Edit the variables for host/guest configuration and run

- libvirt
	- `vm-set*`
		- Run to set input devices for libinput
		- `/var/lib/libvirt/inputs` must be created

## Example configurations

- libvirt
	- A libvirt xml example is included for reference only, with examples of vfio passthrough, etc.
	- Feel free to read through the comments of this file to build a new config yourself

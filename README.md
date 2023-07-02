# SSH Honeypot Proof of Concept
A proof of concept Docker container demonstrating that your username and password inputs are visible to root users on the SSH server you're remoting in to.

## Instructions

System dependencies: Docker and ssh

> Note: Instructions omit the `sudo` before docker commands for brevity.

1. `docker build -t ssh_honey_poc .`

2. `docker run -t -d -p 9000:22 --cap-add=SYS_PTRACE --security-opt seccomp=unconfined ssh_honey_poc`

   Note that this will attach SSH port 22/tcp of the container to port 9000 on your host system, feel free to use another port.

4. The container will be running and capturing all input to it's SSH port, through the binding to the host port localhost:9000.
To SSH into the container run `ssh -p 9000 anyusernameyoulike@localhost`.

5. Once you're happy with your captures and it's time to tear down, simply run `docker ps` to obtain the container id, and then `docker cp <container id>:/capture .` to copy the capture file to your current directory.

   You can also inspect captures while the container is running by running a shell with: `docker exec -it <container id> bash`.

7. Scan the capture file to find the username and password entries.

This PoC was made based on [this great article](https://networklogician.com/2021/04/17/sniffing-ssh-passwords/).

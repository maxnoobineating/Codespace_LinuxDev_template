# Import-Module ./Docker_images_utils.ps1
function New-DevContainer {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Name = "default-devcontainer",
        [string]$Image = "ubuntu-devcontainer:latest",
        [string]$Volume = "devcontainer_workspace"
    )
    # docker run -itd --name $Name -v "$Volume":/root/"$Volume" -v 
    # docker run -itd --name $Name -v "$Volume":/root/"$Volume" -v  <path to: C:\Windows\System32\clip.exe>:/mnt/c/Windows/System32/clip.exe $Image
    docker create -itd --name $Name -v "${Volume}:/root/${Volume}" -v "C:\Windows\System32\clip.exe:/mnt/c/Windows/System32/clip.exe" $Image
    "Container $Name created from $Image"
}

function Set-Ubuntu_ImageUpdate {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Image = "ubuntu-devcontainer:latest"
    )
    docker build --build-arg BASE_IMAGE=$Image -t $Image -f ./dockerfileUpdate.dockerfile .
    "Image $Image updated"
}

function Set-Ubuntu_Devcontainer_ImageSetup {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$BaseImage = "ubuntu-base-image:latest",
        [string]$Name = "ubuntu-devcontainer:latest"
    )
    docker build --build-arg BASE_IMAGE=$BaseImage -t $Name -f ./dotfile_setup.dockerfile .
    "Image $Name dotfiles/packages setup complete"
}

function New-Ubuntu_BaseImage {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]$Name = "ubuntu-base-image:latest"
    )
    docker build -t $Name -f ./dockerfile_base.dockerfile .
    "Base image $Name created"
}
# Remap the CapsLock key to a Control key for
# the X Window system.
if type setxkbmap >/dev/null 2>&1; then
    setxkbmap -layout us -option ctrl:nocaps 2>/dev/null
fi

# ENV

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/intelFPGA_lite/18.1/nios2eds:$PATH"

export QSYS_ROOTDIR="/opt/intelFPGA_lite/18.1/quartus/sopc_builder/bin"

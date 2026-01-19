#!/bin/bash
set -e

echo 19393 | sudo tee /sys/class/backlight/intel_backlight/brightness

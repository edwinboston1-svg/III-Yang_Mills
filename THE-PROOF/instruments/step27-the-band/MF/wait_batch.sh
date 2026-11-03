#!/bin/bash
until [ "$(grep -c 'd=4 L=16 map=box4 dir=3' rec/batch1.2026-11-02a.txt)" -ge 1 ]; do sleep 5; done
echo BATCH-DONE

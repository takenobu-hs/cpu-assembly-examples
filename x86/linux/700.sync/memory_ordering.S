/*
 * Memory ordeirng example for x86/Linux
 *
 *   * see: Intel 64 and IA-32 Architectures Software Developer’s Manual
 *          Volume 3: System Programming Guide:
 *          8.2 MEMORY ORDERING
 *   * see: Intel 64 and IA-32 Architectures Software Developer's Manual
 *          Volumes 2: Instruction Set Reference, A-Z
 *          lfence, sfence, mfence
 */

        .intel_syntax noprefix
        .global main

main:
        /* memory ordering */
        lfence                  /* load fence (load barrier) */

        sfence                  /* store fence (store barrier)*/

        mfence                  /* memory fence (load/store barrier)*/


        /* return from main */
        ret

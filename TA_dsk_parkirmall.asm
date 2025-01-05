DATA SEGMENT
    welcome_msg db 'Selamat Datang di Parkir Mall!', 0Dh, 0Ah, '$'
    prompt_vehicle_number db 'Masukkan Nomor Kendaraan Anda: ', '$'
    vehicle_number db 20, ?, 20 dup('$')
    menu_msg db 'Pilih Jenis Kendaraan:', 0Dh, 0Ah, '$'
    menu_options db '1. Motor', 0Dh, 0Ah, '2. Mobil', 0Dh, 0Ah, '$'
    choice_msg db 'Masukkan pilihan Anda: ', '$'
    invalid_choice db 'Pilihan tidak valid. Coba lagi.', 0Dh, 0Ah, '$'
    time_msg db 'Masukkan Jam Masuk (HHMM): ', '$'
    time_input db 5, ?, 5 dup('$')
    exit_time_msg db 'Masukkan Jam Keluar (HHMM): ', '$'
    exit_time_input db 5, ?, 5 dup('$')
    price_motor db 'Harga parkir untuk motor: Rp2000', 0Dh, 0Ah, '$'
    price_car db 'Harga parkir untuk mobil: Rp5000', 0Dh, 0Ah, '$'
    process_msg db 'Proses selesai. Terima kasih!', 0Dh, 0Ah, '$'
    ask_again db 'Apakah ingin memasukkan kendaraan lain? (Y/N): ', '$'
    exit_msg db 'Program selesai. Sampai jumpa!', 0Dh, 0Ah, '$'
DATA ENDS

CODE SEGMENT
ASSUME CS:CODE, DS:DATA

START:
    ; Inisialisasi Data Segment
    MOV AX, DATA
    MOV DS, AX

    ; Tampilkan ucapan selamat datang
    MOV AH, 09H
    LEA DX, welcome_msg
    INT 21H

INPUT_VEHICLE:
    ; Masukkan nomor kendaraan
    MOV AH, 09H
    LEA DX, prompt_vehicle_number
    INT 21H

    MOV AH, 0AH
    LEA DX, vehicle_number
    INT 21H

MENU:
    ; Tampilkan menu
    MOV AH, 09H
    LEA DX, menu_msg
    INT 21H

    MOV AH, 09H
    LEA DX, menu_options
    INT 21H

    ; Pilih jenis kendaraan
    MOV AH, 01H
    INT 21H
    CMP AL, '1'
    JE MOTOR
    CMP AL, '2'
    JE MOBIL
    JMP INVALID_INPUT

MOTOR:
    ; Proses untuk motor
    MOV AH, 09H
    LEA DX, choice_msg
    INT 21H
    MOV AH, 09H
    LEA DX, time_msg
    INT 21H

    MOV AH, 0AH
    LEA DX, time_input
    INT 21H

    ; Masukkan jam keluar
    MOV AH, 09H
    LEA DX, exit_time_msg
    INT 21H

    MOV AH, 0AH
    LEA DX, exit_time_input
    INT 21H

    ; Tampilkan harga parkir untuk motor
    MOV AH, 09H
    LEA DX, price_motor
    INT 21H
    JMP PROCESS

MOBIL:
    ; Proses untuk mobil
    MOV AH, 09H
    LEA DX, choice_msg
    INT 21H
    MOV AH, 09H
    LEA DX, time_msg
    INT 21H

    MOV AH, 0AH
    LEA DX, time_input
    INT 21H

    ; Masukkan jam keluar
    MOV AH, 09H
    LEA DX, exit_time_msg
    INT 21H

    MOV AH, 0AH
    LEA DX, exit_time_input
    INT 21H

    ; Tampilkan harga parkir untuk mobil
    MOV AH, 09H
    LEA DX, price_car
    INT 21H
    JMP PROCESS

INVALID_INPUT:
    ; Pesan kesalahan
    MOV AH, 09H
    LEA DX, invalid_choice
    INT 21H
    JMP MENU

PROCESS:
    ; Proses selesai
    MOV AH, 09H
    LEA DX, process_msg
    INT 21H

    ; Tanya apakah ingin memasukkan kendaraan lain
    MOV AH, 09H
    LEA DX, ask_again
    INT 21H

    MOV AH, 01H
    INT 21H
    CMP AL, 'Y'
    JE INPUT_VEHICLE
    CMP AL, 'y'
    JE INPUT_VEHICLE
    CMP AL, 'N'
    JE EXIT
    CMP AL, 'n'
    JE EXIT
    JMP INVALID_INPUT

EXIT:
    ; Program selesai
    MOV AH, 09H
    LEA DX, exit_msg
    INT 21H
    MOV AH, 4CH
    INT 21H
CODE ENDS

END START
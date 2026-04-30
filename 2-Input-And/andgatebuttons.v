module top_button_and (
    input btn1,      // S1 butonu
    input btn2,      // S2 butonu
    output out_pin   // PulseView'da izleyeceğin boş pin
);

    // Butonlar Active-Low olduğu için ~ (NOT) operatörü ile tersliyoruz.
    // Böylece basılınca 1, bırakılınca 0 elde ederiz.
    wire b1_pressed = ~btn1;
    wire b2_pressed = ~btn2;

    // AND Kapısı Mantığı
    assign out_pin = b1_pressed & b2_pressed;

endmodule
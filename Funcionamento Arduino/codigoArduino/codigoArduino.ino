//Sensor de temperatura usando o LM35
 
const int LM35 = A5; // Define o pino que lera a saída do LM35
float temperatura; // Variável que armazenará a temperatura medida
int sensorPin = A0;
int sensorValue = 0; 
//Função que será executada uma vez quando ligar ou resetar o Arduino
void setup() {
Serial.begin(9600); // inicializa a comunicação serial
}

//Função que será executada continuamente
void loop() {
temperatura = (float(analogRead(LM35))*5/(1023))/0.01;
sensorValue = analogRead(sensorPin);
Serial.print(temperatura);
Serial.print(";");
Serial.println(sensorValue);
delay(2000);
}

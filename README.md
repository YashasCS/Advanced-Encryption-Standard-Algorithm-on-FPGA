# Advanced Encryption Standard Algorithm Implementation on Zybo FPGA

## Objective
The objective of this project is to implement and compare the iterative and pipelined architectural variants of the Advanced Encryption Standard (AES) cryptographic algorithm's encryption module. Students will implement one or both versions and then report and compare metrics such as power, area, throughput, and latency for the two architectures. The lab also introduces the use of the Virtual Input Output (VIO) IP core to drive input data (plaintext and key) and read the output data (ciphertext) during runtime on the FPGA

## Methodology

1. Implement the pipelined and iterative version of the AES encryption module.
2. Instantiate the PLL to generate a 200 MHz clock from the 125 MHz board clock.
3. Instantiate and configure the Virtual Input/Output (VIO) IP core to interface with the AES module.
4. Configure the VIO for 2 input probes (128-bit ciphertext and valid) and 4 output probes (128-bit plaintext, key, and their valid signals).
5. Verify the design using behavioral simulations with specified input vectors.
6. Generate the bitstream and debug file (*.ltx) to test the design onboard the FPGA using the VIO interface.
7. Report and compare the power, area, throughput, and latency metrics for both the pipelined and iterative architectures

## Design

The lab's design centers on implementing the AES Encryption Core within an FPGA top-level file
alongside two essential components:

* AES Core: Implements the AES encryption module. Must be designed using the Pipelined architecture.
* PLL (Phase-Locked Loop): Generates the 200 MHz clock required to run the AES core from the FPGA's 125 MHz input clock.
* VIO (Virtual Input/Output) IP Core: Serves as the interface to drive the 128-bit key and 128-bit plaintext into the AES module. Used to read the resulting 128-bit ciphertext
from the AES module.

The goal is to implement and compare the physical characteristics of the Pipelined (many round operators used once) and Iterative (one round operator reused 10 times) AES designs.

## Results

### AES Pipelined

* Implemented Design:

<img width="830" height="458" alt="image" src="https://github.com/user-attachments/assets/31c6945d-bbf0-4020-8aa6-1e822fe98b4a" />

<br><br>
* Bitstream Generation:

<img width="830" height="458" alt="image" src="https://github.com/user-attachments/assets/7436ad13-0b51-48fc-bc28-c577c17d915b" />

<br><br>
* Timing Report:

<img width="837" height="134" alt="image" src="https://github.com/user-attachments/assets/ae280b28-3d6a-47f0-8918-17bbfa13777b" />

<br><br>
* Power Report:

<img width="837" height="318" alt="image" src="https://github.com/user-attachments/assets/88aed37d-dee9-4c8b-94e1-eb53c3ace908" />

<br><br>
* Hardware Utilization/Area

<img width="837" height="318" alt="image" src="https://github.com/user-attachments/assets/2a23d666-19d6-4977-be4e-6ee26821fad5" />

<br><br>
* From Latency:
  According to data_valid_in and data_out signals, it takes 42 clock cycles for the output to be calculated and delivered.

  Therefore, Latency = 42 clock => 42 * 10ns = 420ns

* Throughput of the design:
  Stable Throughput is given by the following formula:

  Total bits of output generated / Time to generate a new result

  But since this is the pipelined version of the AES model, a new result comes every clock cycle.
  Therefore, Throughput
  = 128 bits / clock period
  = 128 bits / 10ns
  = 1600MBps

### AES Iterative

* Behavioural Simulation:
<img width="837" height="456" alt="image" src="https://github.com/user-attachments/assets/0264161a-14ca-444f-8afb-bb9476c6f6eb" />

<br><br>
<img width="837" height="456" alt="image" src="https://github.com/user-attachments/assets/ecdc8344-b3a1-4696-bb35-ee34a9918de3" />


<br><br>
* Bitstream Generation:
<img width="837" height="501" alt="image" src="https://github.com/user-attachments/assets/6c0f4db8-564d-478f-b721-0e0c4181a282" />

<br><br>
* Timing Report:
<img width="837" height="188" alt="image" src="https://github.com/user-attachments/assets/ca7a92f8-95f3-4fd6-82c0-f2cbac41f485" />

<br><br>
* Power Report:
<img width="837" height="310" alt="image" src="https://github.com/user-attachments/assets/5c1f5036-cd13-4e6a-841d-3ea87da28246" />

<br><br>
* From Latency:
It is given by how much, time it requires to generate a new data

Therefore, Latency = Time when output generated - Time when input was generated
= 135-25ns
= 110 ns

* Throughput of the design:
Stable Throughput is given by the following formula:

Total bits of output generated / Time to generate a new result
= 128 bits / 110ns
= 1163 Mbps
= 145 MBps

## Comparison of Results

<img width="837" height="139" alt="image" src="https://github.com/user-attachments/assets/a24e6b0d-2192-40c1-b366-ee2a2c543c71" />


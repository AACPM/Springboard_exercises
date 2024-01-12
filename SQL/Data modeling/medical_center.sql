CREATE TABLE doctors (
    doctor_id INT PRIMARY KEY,
    doctor_name VARCHAR(255)
);

CREATE TABLE patients (
    patient_id INT PRIMARY KEY,
    patient_name VARCHAR(255)
);

CREATE TABLE visits (
    visit_id INT PRIMARY KEY,
    doctor_id INT,
    patient_id INT,
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
);

CREATE TABLE diagnoses (
    diagnose_id INT PRIMARY KEY,
    visit_id,
    disease_id,
    FOREIGN KEY (visit_id) REFERENCES visits(visit_id)
    FOREIGN KEY (disease_id) REFERENCES diseases(disease_id)
);

CREATE TABLE diseases (
    disease_id INT PRIMARY KEY,
    disease_name VARCHAR(255)
);
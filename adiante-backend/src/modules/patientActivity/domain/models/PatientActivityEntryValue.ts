class PatientActivityEntryValue {
  id: number;
  value: string;
  idActivityEntry: number;

  constructor(id: number, value: string, idActivityEntry: number) {
    this.id = id;
    this.value = value;
    this.idActivityEntry = idActivityEntry;
  }
}

export default PatientActivityEntryValue;

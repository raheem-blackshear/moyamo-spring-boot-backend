package net.infobank.moyamo.models.board;

public interface WithCondition {
    default ClinicCondition getCondition() {return null;}
}

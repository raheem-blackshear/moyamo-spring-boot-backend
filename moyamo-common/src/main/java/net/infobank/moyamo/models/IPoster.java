package net.infobank.moyamo.models;

import java.util.List;

public interface IPoster<T extends Attachment> {

    List<T> getPosters();
    void setPosters(List<T> posters);
}

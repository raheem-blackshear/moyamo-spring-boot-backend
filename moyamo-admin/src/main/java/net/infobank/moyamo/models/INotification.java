package net.infobank.moyamo.models;


import net.infobank.moyamo.enumeration.OsType;

public interface INotification {
	default String getTitle() {
		return null;
	}

    String getText();

    User getOwner();

    ImageResource getThumbnail();

    Resource asResource();

    default OsType getOsType() {
        return OsType.all;
    }

}

package net.infobank.moyamo.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;
import net.infobank.moyamo.models.INotification;
import net.infobank.moyamo.models.ImageResource;
import net.infobank.moyamo.models.Resource;
import net.infobank.moyamo.models.User;

@Builder
@NoArgsConstructor
@AllArgsConstructor
public class OrderDto implements INotification {

    private static final String RESOURCE_ID = "order";

    private static final Resource resource = new Resource(RESOURCE_ID
            , Resource.ResourceType.shop
            , RESOURCE_ID
            , Resource.ResourceType.shop);

    private String id;
    private String text;
    private String thumbnail;
    private User owner;

    @Override
    public String getText() {
        return this.text;
    }

    @Override
    public User getOwner() {
        return owner;
    }

    @Override
    public ImageResource getThumbnail() {
        return new ImageResource(this.thumbnail, "thumbnail");
    }

    @Override
    public Resource asResource() {
        return resource;
    }
}

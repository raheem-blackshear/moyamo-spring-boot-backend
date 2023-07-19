package net.infobank.moyamo.service;

import lombok.RequiredArgsConstructor;
import net.infobank.moyamo.dto.PostingDto;
import net.infobank.moyamo.models.PhotoAlbum;
import net.infobank.moyamo.models.PhotoPhotoAlbum;
import net.infobank.moyamo.models.board.Photo;
import net.infobank.moyamo.repository.PhotoPhotoAlbumRepository;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class PhotoPhotoAlbumService {

    private final PhotoPhotoAlbumRepository photoPhotoAlbumRepository;


    @Transactional
    public void remove(Photo photo, PhotoAlbum photoAlbum) {
        getPhotoPhotoAlbumByPhotoAndPhotoAlbum(photo, photoAlbum).ifPresent(
                photoPhotoAlbum -> {
                    photo.getPhotoAlbums().removeIf(photoPhotoAlbum1 -> photoPhotoAlbum1.equals(photoPhotoAlbum));
                    photoAlbum.getPhotos().removeIf(photoPhotoAlbum1 -> photoPhotoAlbum1.equals(photoPhotoAlbum));
                    photoPhotoAlbumRepository.delete(photoPhotoAlbum);
                }
        );
    }

    @Transactional
    public void remove(PhotoPhotoAlbum photoPhotoAlbum) {
        Photo photo = photoPhotoAlbum.getPhoto();
        PhotoAlbum photoAlbum = photoPhotoAlbum.getPhotoAlbum();

        photo.getPhotoAlbums().removeIf(photoPhotoAlbum1 -> photoPhotoAlbum1.equals(photoPhotoAlbum));
        photoAlbum.getPhotos().removeIf(photoPhotoAlbum1 -> photoPhotoAlbum1.equals(photoPhotoAlbum));
        photoPhotoAlbumRepository.delete(photoPhotoAlbum);

    }

    @Transactional
    public void save(PhotoPhotoAlbum photoPhotoAlbum) {
        photoPhotoAlbumRepository.save(photoPhotoAlbum);
    }

    @Transactional
    public Optional<PhotoPhotoAlbum> getPhotoPhotoAlbumByPhotoAndPhotoAlbum(Photo photo, PhotoAlbum photoAlbum) {
        return photoPhotoAlbumRepository.findByPhotoAndPhotoAlbum(photo, photoAlbum);
    }

    @Transactional
    public void removeAll(List<PhotoPhotoAlbum> list){

        for (int i=0;i<list.size();i++) {
            PhotoPhotoAlbum ppa = list.get(i);
            ppa.getPhoto().getPhotoAlbums().removeIf(photoPhotoAlbum -> photoPhotoAlbum.equals(ppa));
            ppa.getPhotoAlbum().getPhotos().removeIf(photoPhotoAlbum -> photoPhotoAlbum.equals(ppa));
            photoPhotoAlbumRepository.delete(ppa);
            i--;
        }

    }

    public List<PostingDto> getPhotoByPhotoAlbumContainsQuery(PhotoAlbum photoAlbum, String query, Pageable pageable){
        List<Photo> photos = photoPhotoAlbumRepository.findPhotoByPhotoAlbum(photoAlbum, query, pageable);
        return photos.stream().map(PostingDto::of).collect(Collectors.toList());
    }
    public List<PostingDto> getPhotoByPhotoAlbum(PhotoAlbum photoAlbum, String query){
        List<Photo> photos = photoPhotoAlbumRepository.findPhotoByPhotoAlbum(photoAlbum, query);
        return photos.stream().map(PostingDto::of).collect(Collectors.toList());
    }
}

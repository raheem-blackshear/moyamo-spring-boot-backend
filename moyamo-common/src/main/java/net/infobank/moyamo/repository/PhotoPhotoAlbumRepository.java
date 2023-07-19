package net.infobank.moyamo.repository;

import net.infobank.moyamo.models.PhotoAlbum;
import net.infobank.moyamo.models.PhotoPhotoAlbum;
import net.infobank.moyamo.models.board.Photo;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;
import java.util.List;

public interface PhotoPhotoAlbumRepository extends JpaRepository<PhotoPhotoAlbum, Long> {

    @Query("select ppa from PhotoPhotoAlbum ppa where ppa.photo = :photo and ppa.photoAlbum = :photoAlbum")
    Optional<PhotoPhotoAlbum> findByPhotoAndPhotoAlbum(@Param("photo") Photo photo, @Param("photoAlbum") PhotoAlbum photoAlbum);

    @Query("select ppa.photo from PhotoPhotoAlbum ppa where ppa.photoAlbum = :photoAlbum and ppa.photo.text like concat('%',:query,'%') ")
    List<Photo> findPhotoByPhotoAlbum(@Param("photoAlbum") PhotoAlbum photoAlbum, @Param("query") String query, Pageable pageable);

    @Query("select ppa.photo from PhotoPhotoAlbum ppa where ppa.photoAlbum = :photoAlbum and ppa.photo.text like concat('%',:query,'%')")
    List<Photo> findPhotoByPhotoAlbum(@Param("photoAlbum") PhotoAlbum photoAlbum,  @Param("query") String query);
}

from glob import glob
import os


def get_sub_list(train_img_dir):
    image_list = []
    # get all the T1w images from the bids_dir
    image_files = glob(os.path.join(train_img_dir, "*T1w.nii.gz"))
    image_files.sort()
    for name in image_files:
        image_list.append(os.path.basename(name)[:-7])
    return image_list, image_files


def get_sub_from_txt(train_txt, trainnii_txt, label_txt, labelnii_txt):
    fp_train = open(train_txt, 'r')
    sublines_train = fp_train.readlines()
    fp_trainnii = open(trainnii_txt, 'r')
    sublines_trainnii = fp_trainnii.readlines()
    fp_label = open(label_txt, 'r')
    sublines_label = fp_label.readlines()
    fp_labelnii = open(labelnii_txt, 'r')
    sublines_labelnii = fp_labelnii.readlines()

    train_img_subs = []
    train_img_files = []
    train_seg_subs = []
    train_seg_files = []

    for subline in sublines_train:
        sub_info = subline.replace('\n', '')
        train_img_subs.append(sub_info)

    fp_train.close()

    for subline in sublines_trainnii:
        sub_info = subline.replace('\n', '')
        train_img_files.append(sub_info)

    fp_trainnii.close()

    for subline in sublines_label:
        sub_info = subline.replace('\n', '')
        train_seg_subs.append(sub_info)

    fp_label.close()

    for subline in sublines_labelnii:
        sub_info = subline.replace('\n', '')
        train_seg_files.append(sub_info)

    fp_labelnii.close()

    return train_img_subs, train_img_files, train_seg_subs, train_seg_files

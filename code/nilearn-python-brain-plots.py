from nilearn.plotting import plot_glass_brain
import nibabel as nib
from nilearn import plotting

# Load the contrast image in NIfTI format
spl_image_path = '/Users/apple/PycharmProjects/nilearn_practicals/created_cons/switch_tmaps/secondlvl_switch_7a.nii'
spl_img = nib.load(spl_image_path)

s1_image_path = '/Users/apple/PycharmProjects/nilearn_practicals/created_cons/switch_tmaps/secondlvl_switch_s1.nii'
s1_img = nib.load(s1_image_path)

s2_image_path = '/Users/apple/PycharmProjects/nilearn_practicals/created_cons/switch_tmaps/switch_group_SIImasked.nii'
s2_img = nib.load(s2_image_path)


display = plot_glass_brain(None, threshold=None, plot_abs=False, display_mode="lzry")
display.add_contours(s1_img, filled=True, colors="b")
display.add_contours(spl_img, filled=True, colors="g")
display.add_contours(s2_img, filled=True, colors="r")
display.title("SI, SII and SPL ROIs of Second-Level Switches (both directions)")

# Finally, displaying them
plotting.show()

from PIL import Image
import numpy as np
import matplotlib.pyplot as plt

cx = 920
cy = 800
w = 400
h = 200
crop_area = (cx-w, cy-h, cx+w, cy+h)

files = [
    'Fourier/0.25_redo/media/im_0248_20240202_193032.jpg',
    'Fourier/1_redo/media/im_0254_20240202_193430.jpg',
    'Fourier/2_redo/media/im_0258_20240202_193756.jpg',
    'Fourier/4_redo/media/im_0265_20240202_194101.jpg',
]

imgs = [np.array(Image.open(file).convert('L').crop(crop_area)) for file in files]

I = [im.sum(axis=0) for im in imgs]

px_to_mm = 0.0658
dists = [0.25, 1, 2, 4]

X = np.linspace(-w*px_to_mm, w*px_to_mm, 2*w)

fig, axs = plt.subplots(4, 1, figsize=(10, 8), sharex=True, sharey=True)
fig.suptitle('Cross Section Intensity of Slit Diffraction')

for i, intensity in enumerate(I):
    axs[i].plot(X, intensity)
    axs[i].set_title("Intensity for $w /\\sqrt{\\lambda z/\\pi}=$ "+str(dists[i]))

for ax in axs:
    ax.set_xlabel('Position (mm)')
    ax.set_ylabel('Intensity (Arbitrary Scale)')

plt.tight_layout(rect=[0, 0.03, 1, 0.95])
plt.show()


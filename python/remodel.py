#import torchvision.models as models
from torch import nn
# model = models.resnet50(pretrained=True)
# fc_features = model.fc.in_features
# model.fc = nn.Linear(fc_features, 8)
#import datetime
#import os
#import os.path as osp
#import numpy as np
#import pytz
#import scipy.misc
#import nibabel as nib
import torch
#from torch.autograd import Variable
#import torch.nn.functional as F
#import tqdm
class UNet3D(nn.Module):
    def __init__(self, in_channel, n_classes):
        self.in_channel = in_channel
        self.n_classes = n_classes
        super(UNet3D, self).__init__()
        self.ec0 = self.encoder(self.in_channel, 32, bias=True, batchnorm=True)
        self.ec1 = self.encoder(32, 64, bias=True, batchnorm=True)
        self.ec2 = self.encoder(64, 64, bias=True, batchnorm=True)
        self.ec3 = self.encoder(64, 128, bias=True, batchnorm=True)
        self.ec4 = self.encoder(128, 128, bias=True, batchnorm=True)
        self.ec5 = self.encoder(128, 256, bias=True, batchnorm=True)
        self.ec6 = self.encoder(256, 256, bias=True, batchnorm=True)
        self.ec7 = self.encoder(256, 512, bias=True, batchnorm=True)
        self.pool0 = nn.MaxPool3d(2)
        self.pool1 = nn.MaxPool3d(2)
        self.pool2 = nn.MaxPool3d(2)
        self.dc9 = self.decoder(512, 512, kernel_size=2, stride=2, bias=True)
        self.dc8 = self.decoder(256 + 512, 256, kernel_size=3, stride=1, padding=1, bias=True)
        self.dc7 = self.decoder(256, 256, kernel_size=3, stride=1, padding=1, bias=True)
        self.dc6 = self.decoder(256, 256, kernel_size=2, stride=2, bias=True)
        self.dc5 = self.decoder(128 + 256, 133, kernel_size=3, stride=1, padding=1, bias=True)
        self.dc4 = self.decoder(133, 133, kernel_size=3, stride=1, padding=1, bias=True)
        self.dc3 = self.decoder(133, 133, kernel_size=2, stride=2, bias=True)
        self.dc2 = self.decoder(64 + 133, 133, kernel_size=3, stride=1, padding=1, bias=True)
        self.dc1 = self.decoder(133, n_classes, kernel_size=3, stride=1, padding=1, bias=True)
        self.dc0 = self.decoder(64, n_classes, kernel_size=1, stride=1, bias=True)

    def encoder(self, in_channels, out_channels, kernel_size=3, stride=1, padding=1, bias=True, batchnorm=True):
        if batchnorm:
            layer = nn.Sequential(
                nn.Conv3d(in_channels, out_channels, kernel_size, stride=stride, padding=padding, bias=bias),
                nn.BatchNorm3d(out_channels),
                nn.ReLU())
        else:
            layer = nn.Sequential(
                nn.Conv3d(in_channels, out_channels, kernel_size, stride=stride, padding=padding, bias=bias),
                nn.ReLU())
        return layer

    def decoder(self, in_channels, out_channels, kernel_size, stride=1, padding=0,
                output_padding=0, bias=True):
        layer = nn.Sequential(
               nn.ConvTranspose3d(in_channels, out_channels, kernel_size, stride=stride, padding=padding, output_padding=output_padding, bias=bias),
               nn.ReLU())
        return layer

    def forward(self, x):
        e0 = self.ec0(x)
        syn0 = self.ec1(e0)
        e1 = self.pool0(syn0)
        e2 = self.ec2(e1)
        syn1 = self.ec3(e2)
        del e0, e1, e2
        e3 = self.pool1(syn1)
        e4 = self.ec4(e3)
        syn2 = self.ec5(e4)
        del e3, e4
        e5 = self.pool2(syn2)
        e6 = self.ec6(e5)
        e7 = self.ec7(e6)
        e9 = self.dc9(e7)
        del e5, e6
        #print("block e7 size = %s" % (str(e7.size())))
        #print("block dc9 size = %s" % (str(self.dc9(e7).size())))
        #print("block syn2 size = %s" % (str(syn2.size())))
        d9 = torch.cat((self.dc9(e7), syn2), 1)
        #print("block d9 size = %s" % (str(d9.size())))
        del e7, syn2
        d8 = self.dc8(d9)
        d7 = self.dc7(d8)
        # print("block d8 size = %s" % (str(d8.size())))
        del d9, d8
        dd7 = self.dc6(d7)
        # print("block d7 size = %s" % (str(d7.size())))
        d6 = torch.cat((self.dc6(d7), syn1), 1)
        del d7, syn1
        d5 = self.dc5(d6)
        d4 = self.dc4(d5)
        # print("block d5 size = %s" % (str(d5.size())))
        # print("block d4 size = %s" % (str(d4.size())))
        del d6, d5
        d3 = torch.cat((self.dc3(d4), syn0), 1)
        del d4, syn0
        # print("block d3 size = %s" % (str(d3.size())))
        d2 = self.dc2(d3)
        d1 = self.dc1(d2)
        # print("block d2 size = %s" % (str(d2.size())))
        # del d3, d2
        # print("block d1 size = %s" % (str(d1.size())))
        #d0 = self.dc0(d1)
        return d1
epoch = 4
out = '/media/ethanyue/Yue/201910-202110academic/SLANT/nssresult/test/1_1_1/test_out/models'
model_pth = '%s/model_epoch_%04d.pth' % (out, epoch)
model = UNet3D(in_channel=1, n_classes=134)
#model.load_state_dict(torch.load(model_pth))
#model_dict = model.state_dict()
model.load_state_dict(torch.load(model_pth))
model.dc0 = nn.Sequential(nn.ConvTranspose3d(64, 134, 1), *list(model.dc0.children())[1:])
model.dc1 = nn.Sequential(nn.ConvTranspose3d(133, 134, 3), *list(model.dc1.children())[1:])
torch.save(model.state_dict(),'/media/ethanyue/Yue/201910-202110academic/SLANT/nssresult/test/1_1_1/test_out/models/134model_epoch_ft_0000.pth')


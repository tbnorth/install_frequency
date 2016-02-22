

stats = c()
all = data.frame()
for (input in c("subset.A.txt", "subset.B.txt")) {
  d = read.table(input)
  d$V1 = as.POSIXct(d$V1)
  d = d[order(d$V1), ]
  a = aggregate(d$V1, list(date=as.POSIXct(d$V1)), length)
  stats = c(stats, diff(a$date))
  all = rbind(all, data.frame(date=a$date, count=a$x, which=as.character(input)))
}
all$which = as.factor(all$which)
summary(stats)
str(all)

png("install_freq.png", 1024, 768)
par(cex = 1.4)
plot(all$date, all$count, col=all$which, 
  main="Package installs over time (new packages only, updates excluded)",
  xlab="Date (2015-2016)", ylab="Packages installed", 
  type='h', xaxt = "n")
  
points(all$date, all$count, col=all$which, pch=20)

legend('topright', legend=c('Machine A', 'Machine B'), pc=19, col=c(1,2))

axis.POSIXct(1, at=seq(min(all$date), max(all$date), by="month"))
dev.off()

